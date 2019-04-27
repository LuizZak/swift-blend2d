# Check git satus and make sure we don't modify the working tree with update changes by mistake
if [[ -n $(git status --porcelain) ]]; then
    echo "Current git repo's state is not commited! Please commit and try again."
    exit 1
fi

echo "Creating temporary path folder ./temp..."

if [[ -d "temp" ]]; then
    rm -rf temp
fi

mkdir temp

cd temp
git clone https://github.com/blend2d/blend2d.git --depth=1
git clone https://github.com/asmjit/asmjit --branch next-wip --depth=1

# Copy all Blend2D files over
echo "Copying over Blend2D files..."

if [[ -d blend2d/src ]] && cp -R blend2d/src/ ../Sources/blend2d; then
    true
else
    echo "Error while copying over Blend2D files: Could not locate source files path."
    exit 1
fi

# Now copy all asmjit files over
echo "Copying over asmjit files..."

if [[ -d asmjit/src ]] && cp -R asmjit/src/asmjit/ ../Sources/asmjit/; then
    true
else
    echo "Error while copying over asmjit files: Could not locate source files path."
    exit 1
fi

cd ..

rm -rf temp

echo "Success!"

if [[ -n $(git status --porcelain) ]]; then
    echo "New unstaged changes:"
    git status --porcelain
fi
