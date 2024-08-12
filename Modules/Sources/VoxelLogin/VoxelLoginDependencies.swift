import Foundation
import VoxelAuthentication

public protocol VoxelLoginDependencies {
    var authService: AuthService { get }
}
